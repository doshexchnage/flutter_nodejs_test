import * as jwt from 'jsonwebtoken';
import { NextFunction, Request, Response} from 'express';
import { JWT_SECRET } from "../util/secrets";


export function createJWT(userID: string, username: string) {
    const token = jwt.sign({id: userID, username: username},
        JWT_SECRET, {expiresIn: "30m"});
    return token;
}

export function verifyToken(req: Request, res: Response, next: NextFunction){
    const token = req.headers['x-access-token'] as string;
    if (token) {
        
        jwt.verify(token, JWT_SECRET, (err, user) => {
            if (err) {
                return res.json({status: 'display-error', error: 'Unauthorized access'});
            }
            next();        
        });
    }else {
        return res.json({status: 'error', error: 'Token not provided'});
    }
              
    
}



