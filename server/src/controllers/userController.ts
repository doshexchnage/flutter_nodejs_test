import bcrypt from "bcrypt-nodejs";
import { Request, Response } from "express";
import { User } from "../models/user";
import { createJWT, verifyToken } from "./tokenUtils";



export class UserController {

  public async registerUser(req: Request, res: Response): Promise<void> {
    const hashedPassword = bcrypt.hashSync(req.body.password, bcrypt.genSaltSync(10));

    User.findOne({username: req.body.username}, (err, result) => {
        if(err){
            return res.json({status: 'error', err});   
        }
        if (result) {
            return res.json({status: 'display-error', error: 'Username is taken!'});
        }
        else {
			User.create({username: req.body.username, password: hashedPassword}, (err: Error) => {
				if(err){
					
					return res.json({status: 'error', err});   
				}
				return res.json({status: 'ok', message : `User ${req.body.username} created registered successfully!`});
			});
		}
    });    
  }

  public async login(req: Request, res: Response): Promise<void> {
    const { username, password} = req.body;

    
    User.findOne({username}, (err, user) => {
        if (err) {
            return res.json({status: 'error', err});
        }
        if (!user) {
            return res.json({status: 'display-error', error: 'Invalid username'});
        }

        bcrypt.compare(password, user.password, (err, result) => {

            if (err) {
                return res.json({status: 'error', err});
            }
            if (!result) {
                return res.json({status: 'display-error', error: 'Invalid password'});
            }
            const token = createJWT(user._id, username);
            return res.json({status: 'ok', message: 'Successfully logged in!', authToken: token});
        });
        
    });
  }
}