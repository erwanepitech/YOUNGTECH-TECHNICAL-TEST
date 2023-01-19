const db = require("../models");
const config = require("../config/auth.config");
const User = db.user;

exports.allAccess = (req, res) => {
    res.status(200).send("Public Content.");
};

exports.userBoard = (req, res) => {

    console.log(req.userId);

    User.findOne({
        where: {
            id: req.userId
        }
    })
        .then(user => {
            if (!user) {
                return res.status(404).send({ message: "User Not found." });
            }
        
            res.status(200).send({
                id: user.id,
                username: user.username,
                email: user.email,
            });
        })
        .catch(err => {
            res.status(500).send({ message: err.message });
        });
};

exports.getUser = (req, res) => {

    console.log(req.params.id);

    User.findOne({
        where: {
            id: req.params.id
        }
    })
        .then(user => {
            if (!user) {
                return res.status(404).send({ message: "User Not found." });
            }
        
            res.status(200).send({
                id: user.id,
                username: user.username,
                email: user.email,
            });
        })
        .catch(err => {
            res.status(500).send({ message: err.message });
        });
};
