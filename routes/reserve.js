var express = require('express');
var router = express.Router();
var connection = require('../db/connection');

// Init API reservation
router.post('/:userID/:foodCount', function(req, res, next) {
  // Reservation food for the user
  connection.query(`INSERT INTO reservation_food (userID, reserve, taken, date) VALUES ('${req.params.userID}','${req.params.foodCount}',0,'${new Date()}');`)

  // Sent to Client a JSON ( use function resCount To calculate the remaining reservation capacity )
  res.send({result:true, msg:"User's food was successfully reserved" ,totalReservations:resCount(req.params.userID)});
});

// Init API list of all reservations
router.get('/all/:userID', function(req, res) {
  // I have taken the user's get_food information
  let result = connection.query(`SELECT * FROM reservation_food WHERE userID=${req.params.userID}`);
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
