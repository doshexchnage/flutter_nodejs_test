const router = require('express').Router();
let Weight = require('../../models/Weight');
const jwt = require('jsonwebtoken')
const keys = require("../../config/keys");

router.route('/').get((req, res) => {

    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1].slice(0,-1)
    if(token == null) return res.sendStatus(401).json({msg:"Error is here"})
    jwt.verify(token, keys.secretOrKey, (err, user) =>{
        if(err) return res.sendStatus(403);
        req.user = user;
    });
    Weight.find({username:req.user.name})
        .then(weights => res.json(weights))
        .catch(err => res.status(400).json('Error: '+ err));
});

router.route('/add').post((req, res) => {

    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]
    if(token == null) return res.sendStatus(401).json({msg:"Error is here"})

    jwt.verify(token, keys.secretOrKey, (err, user) =>{
        if(err) return res.sendStatus(403).json("Hos");
        req.user = user;
    });

    const username = req.user.name;
    const weight = req.body.weight;
    const date = Date.parse(req.body.date);

    const newWeight = new Weight({
        username,
        weight,
        date,
    });

    newWeight.save()
        .then(() => res.json('Weight added!'))
        .catch(err => res.status(400).json('Error: '+ err));
});

router.route('/:id').get( (req, res) => {
    Weight.findById(req.params.id)
        .then(weight => res.json(weight))
        .catch(err => res.status(400).json('Error: ' +err));
});

router.route('/:id').delete((req, res) => {
    Weight.findByIdAndDelete(req.params.id)
        .then(() => res.json('Weight Deleted'))
        .catch(err => res.status(400).json('Error: ' +err));
});

router.route('/update/:id').post((req, res) =>{
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]
    if(token == null) return res.sendStatus(401).json({msg:"Error is here"})

    jwt.verify(token, keys.secretOrKey, (err, user) =>{
        if(err) return res.sendStatus(403);
        req.user = user;
    });
    Weight.findById(req.params.id)
        .then(weight => {
            weight.username = req.user.name;
            weight.weight = req.body.weight;
            weight.date = req.body.date;

            weight.save()
                .then(() =>res.json('Weight Updated'))
                .catch(err => res.status(400).json('Error: '+err));
        })
        .catch(err => res.status(400).json('Error: '+err));
})


module.exports = router;
