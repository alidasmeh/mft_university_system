var express = require('express');
var router = express.Router();

/* GET api page. */
router.get('/', function(req, res) {
    res.render('api');
});

module.exports = router;