var express = require('express');
var router = express.Router();
var connection = require('../db/connection');

// Init API getting_food
router.post('/:userID', function(req, res) {
    // In the command down : I have taken the user's reservation information on the condition that it has reservation capacity.
    let data = connection.query(`SELECT * FROM reservation_food WHERE userID=${req.params.userID} AND reserve != taken`);

    if (data.length>0){ // If user had reservations > user is allowed to get food.

        // Insert in the db (in table getting_food ) that user has taken the food.
        connection.query(`INSERT INTO getting_food (userID, date) VALUES ('${req.params.userID}','${new Date()}')`)

        // َadd a value of 1 to taken field in the db (in table reservation_food ).
        connection.query(`UPDATE reservation_food SET taken = ${1 + data[0].taken} WHERE resID=${ data[0].resID }`)

        // Sent to Client a JSON ( use function resCount To calculate the remaining reservation capacity )
        res.send({result:true , msg:`The user with ID ${req.params.userID} is allowed to take food`, reservations:resCount(req.params.userID)});

    }else{ //If user had no reservations > user is not allowed to get food.
        res.send({result:false , msg:`Sorry, The user with ID ${req.params.userID} is not allowed to take food`});

    }
});

// Init API list of all getting_food
router.get('/all/:userID', function(req, res) {
    // I have taken the user's get_food information
    let result = connection.query(`SELECT * FROM getting_food WHERE userID=${req.params.userID}`);
    if(result.length>0){
        res.send(result);
    }else{
        res.send(`User with ID ${req.params.userID} was not found`);
    }
});


function resCount(id){
    // Get all user reservations from the db
    let reservations = connection.query(`SELECT reserve FROM reservation_food WHERE userID=${id}`);
    var sumReservations = 0; 
    reservations.forEach(item => {
        sumReservations=sumReservations+item.reserve
    });

    // Get all the getFood the user from the db
    let get_food = connection.query(`SELECT * FROM getting_food WHERE userID=${id}`).length;

    // The remaining capacity is calculated from subtraction sumReservations and get_food
    let reservationsCount = sumReservations-get_food
    return reservationsCount
}

module.exports = router;