let express = require('express');
let router = express.Router();
let connection = require('../db/connection');

function add_selected_course_in_db(course_id, user_id ,semester_id){
    
    let new_selected_course = connection.query(`SELECT * FROM courses_list WHERE course_list_id = ${course_id} AND semester_id = ${semester_id}`)[0];
    // insert the selected course from url in database
    let inserting_new_course = connection.query(`INSERT INTO selected_courses (user_id, course_list_id, semester_id, date) VALUES (${user_id}, ${course_id}, ${semester_id},"${new Date().getTime()}" )`);
    let inserting_status = true;

    if( inserting_new_course.affectedRows > 0 ){
        // update course_list (used + 1)
        let used = new_selected_course.used + 1;
        let update_course_list = connection.query(`UPDATE courses_list SET used = ${used} WHERE course_list_id = ${course_id} AND semester_id = ${semester_id}`);
        
        if( update_course_list.affectedRows > 0 ){
            // everything OK and course added and courses_list (used field) updated
            inserting_status = true;
        }else{
            res.send({result: false, msg: 'course added but courses_list (used field) not updated'});
            inserting_status = false
        }
    }else{
        // selected course from url not inserted in database
        inserting_status = false;
        res.send({result: false, msg: 'Selected course from url not inserted in database'});
    }

    return inserting_status;
}

router.get('/all_courses/:semester_id', function(req, res, next) {

    // Show list of courses
    let all_courses = [];
    let days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
    // join 3 tables (courses, courses_list, professors) together as 'courses_info' variable
    let courses_info = connection.query(`SELECT courses.name AS course_name, courses.class_duration, courses_list.course_list_id, courses_list.number_of_students, courses_list.used, courses_list.class_start_time, professors.fullname AS professor_name FROM courses_list INNER JOIN courses ON courses.course_id = courses_list.course_id AND courses_list.semester_id = ${req.params.semester_id} INNER JOIN professors ON professors.professor_id = courses_list.professor_id`)
    
    courses_info.forEach( course => {

        // Prepare time of class like (Sunday - (10:30:00 - 12:0:00))
        let class_duration = parseFloat(course.class_duration) * 3600 * 1000 ;

        let class_start_time = `${ new Date( parseInt(course.class_start_time) ).getHours() }:${ new Date( parseInt(course.class_start_time) ).getMinutes() }:00`; // get hour & minute from 'class_start_time'
        let class_finish_time = `${ new Date( class_duration + parseInt(course.class_start_time) ).getHours() }:${ new Date( class_duration + parseInt(course.class_start_time) ).getMinutes() }:00`; // get.hour() & get.minute() from (class_finish_time = class_start_time + duration_of_class)
        let day = days[ new Date( parseInt(course.class_start_time) ).getDay() ]; // example : days[0] = Sunday, days[1] = Monday        
        
        // Put the information in one object 
        let object = {};
        object['course_list_id'] = course.course_list_id;
        object['course'] =  course.course_name;
        object['professor'] = course.professor_name;
        object['class_time'] = `${day} - (${class_start_time} - ${class_finish_time})`;
        object['class_duration'] = `${course.class_duration}h`;
        object['number_of_students'] = course.number_of_students;
        object['used'] = course.used;

        // push the object of each course to 'all_courses'
        all_courses.push(object)
    });

    res.send(all_courses);
});

router.get('/select_courses/:semester_id/:id',async function(req, res, next) {
    
    let user_id = req.cookies.user_id;
    // checks capacity of credits selection
    let user_credits_number = 0;
    let user_courses = connection.query(`SELECT * FROM selected_courses WHERE user_id = ${req.cookies.user_id} AND semester_id = ${req.params.semester_id}`);

    user_courses.forEach( user_course => {
        // Adds all credits numbers together then check 
        let course_credit_number = connection.query(`SELECT courses.credits_number FROM courses INNER JOIN courses_list ON courses.course_id = courses_list.course_id AND courses_list.course_list_id = ${user_course.course_list_id}`)[0]
        user_credits_number += course_credit_number.credits_number;
    });

    // The maximum credits selection is 20
    if( user_credits_number < 20 ){  

        // checks the id of url exist or not? and checks the class has the capacity or not?
        let course = connection.query(`SELECT * FROM courses_list WHERE course_list_id = ${req.params.id} AND number_of_students > used AND semester_id = ${req.params.semester_id}`);

        if( course.length == 1 ){

            let previous_selected_courses = connection.query(`SELECT * FROM selected_courses WHERE user_id = ${user_id}`);

            if( previous_selected_courses.length < 1){ 

                // add user selected course for first time
                let report = await add_selected_course_in_db(req.params.id, user_id ,req.params.semester_id);
                if(report){
                    // everything OK and course added and courses_list (used field) updated
                    res.send({result: true, msg: 'Course added and courses_list (used field) updated'});
                }else{
                    // error in updating or inserting
                    res.send({result: false, msg: 'ERROR in : Course added and courses_list (used field) updated'});
                }
            }else{

                // in this block of code :
                // 1- We create an array of user selectedـcourse IDs
                // 2- We checks that the names of the selected courses in the database are not equal to the names of the selected course in url
                // 3- We checks that the time of the selected courses in the database does not interfere with the time of the selected course in the url

                // We create an array of user selectedـcourse IDs
                arr_previous_selected_courses = [];
                previous_selected_courses.forEach( d => {
                    arr_previous_selected_courses.push( d.course_list_id );
                });
                
                // If the credits number of the newly selected course is more than 20 with the total credits number of the previous courses, get an error 
                let new_selected_course = connection.query(`SELECT * FROM courses_list WHERE course_list_id = ${req.params.id} AND semester_id = ${req.params.semester_id}`)[0];
                let course_info = connection.query(`SELECT * FROM courses WHERE course_id = ${new_selected_course.course_id}`)[0];

                if( (course_info.credits_number + user_credits_number) <= 20 ){
                    
                    // prepare the time of new selected course in url 
                    let start_new_class = parseInt(new_selected_course.class_start_time);
                    let new_class_duration = parseFloat(course_info.class_duration);
                    let finish_new_class = start_new_class + (new_class_duration * 3600 * 1000);
                    
                    let duplicate_error = false;
                    let duplicate_course = "";
                    let time_interference_error = false;
                    let time_interference_course = "";

                    // We checks that the names of the selected courses in the database are not equal to the names of the selected course in url
                    arr_previous_selected_courses.forEach( row => {

                        let course_details = connection.query(`SELECT * FROM courses_list WHERE course_list_id = ${row} AND semester_id = ${req.params.semester_id}`) [0];
                        while( course_details.course_id === new_selected_course.course_id ){
                            // Course is duplicate
                            duplicate_error = true;
                            duplicate_course = connection.query(`SELECT * FROM courses WHERE course_id = ${course_details.course_id} `)[0]; // name of duplicate course
                            break;
                        }                
                    });

                    if( duplicate_error == false ){

                        //We checks that the time of the selected courses in the database does not interfere with the time of the selected course in the url
                        // If there is a commonality between the two times, it is considered a time interference
                        arr_previous_selected_courses.forEach( row => {

                            let course_details = connection.query(`SELECT * FROM courses_list WHERE course_list_id = ${row} AND semester_id = ${req.params.semester_id}`) [0];
                            let course_duration = connection.query(`SELECT * FROM courses WHERE course_id = ${course_details.course_id} `)[0];
                
                            // prepare the times of new selected course in url 
                            let start_previous_class = parseInt(course_details.class_start_time); 
                            let previous_class_duration = parseFloat(course_duration.class_duration);
                            let finish_previous_class = start_previous_class + (previous_class_duration * 3600 * 1000);
                            
                            while( (start_previous_class < start_new_class && start_new_class < finish_previous_class) || (start_previous_class < finish_new_class && finish_new_class < finish_previous_class) ){ 
                                time_interference_error = true;
                                time_interference_course = connection.query(`SELECT * FROM courses WHERE course_id = ${course_details.course_id} `)[0]; // The name of the course that interferes with the selected of your course (req.params.id)
                                break;
                            }             
                        });

                        if( time_interference_error == false ){

                            // insert the selected course from url in database
                            let report = await add_selected_course_in_db(req.params.id, user_id, req.params.semester_id);
                            if(report){
                                // everything OK and course added and courses_list (used field) updated
                                res.send({result: true, msg: 'Course added and courses_list (used field) updated'});
                            }else{
                                // error in updating or inserting
                                res.send({result: false, msg: 'ERROR in : Course added and courses_list (used field) updated'});
                            }

                        }else{
                            res.send({result: false, msg: `Error : The course of your choice interfere with ${time_interference_course.name} `});
                        }
                    }else{
                        res.send({result: false, msg:` ${duplicate_course.name} is duplicate`});
                    }
                }else{
                    res.send({result: false, msg: 'Error : By selecting this course, the number of creadits will increase to more than 20'});
                }
            }                            
        }else{
            res.send({ result: false, msg: 'Class capacity is complete or wrong id inputed'})
        }
    }else{
        res.send({ result: false, msg: `user_id = ${user_id}, The courses of your choice are more than 20 credits`})
    }
});

router.get('/user_choices/:semester_id', function(req, res, next){

    // Show list of selected user courses
    let user_id = req.cookies.user_id;
    let all_courses = [];
    var price = 0;
    var number_of_user_credits = 0;
    let days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
    let user_courses = connection.query(`SELECT * FROM selected_courses WHERE user_id = ${user_id} AND semester_id = ${req.params.semester_id}`);

    user_courses.forEach( user_course => {

        // join 3 tables (courses, courses_list, professors) together with 'user_courses' as 'courses_info' variable    
        let course_info = connection.query(`SELECT courses.name AS course_name, courses.credits_number, courses.price, courses.class_duration, courses_list.course_list_id, courses_list.number_of_students, courses_list.used, courses_list.class_start_time, professors.fullname AS professor_name FROM courses_list INNER JOIN courses ON courses.course_id = courses_list.course_id AND courses_list.course_list_id = ${user_course.course_list_id} INNER JOIN professors ON professors.professor_id = courses_list.professor_id`)[0]
        
        // Prepare time of class like (Sunday - (10:30:00 - 12:0:00)
        let class_duration = (parseFloat(course_info.class_duration) * 3600 * 1000) ;
        let class_start_time = `${ new Date( parseInt(course_info.class_start_time) ).getHours() }:${ new Date( parseInt(course_info.class_start_time) ).getMinutes() }:00`; // get hour & minute from 'class_start_time'
        let class_finish_time = `${ new Date( class_duration + parseInt(course_info.class_start_time) ).getHours() }:${ new Date( class_duration + parseInt(course_info.class_start_time) ).getMinutes() }:00`; // get.hour() & get.minute() from (class_finish_time = class_start_time + duration_of_class)
        let day = days[ new Date( parseInt(course_info.class_start_time) ).getDay() ]; // example : days[0] = Sunday, days[1] = Monday
        
        // add price of each selected course together 
        price += parseInt(course_info.price);

        // add credits number of each selected course together (total user credits)
        number_of_user_credits += parseInt(course_info.credits_number);

        // Put the information in one object 
        let object = {};
        object['course_list_id'] = course_info.course_list_id;
        object['course'] =  course_info.course_name;
        object['professor'] = course_info.professor_name;
        object['class_time'] = `${day} - (${class_start_time} - ${class_finish_time})`;
        object['class_duration'] = `${course_info.class_duration}h`;
        object['number_of_students'] = course_info.number_of_students;
        object['used'] = course_info.used;

        // push the object of each course to 'all_courses'
        all_courses.push(object)
    });

    // add price and credits number at the end of 'all_course' array
    all_courses.push({total_price : `${price} T`});
    all_courses.push({number_of_user_credits : `${number_of_user_credits}`});

    res.send(all_courses);
});

module.exports = router;