import * as jwt from 'jsonwebtoken';
import { GetUserWhere } from '../services';

const KEY = 'Vdz7>K@W!5}pknh';

export async function AuthCheck(req, res, next) {
  const tokenRaw = req.header('Authorization');

  try {
    if (!tokenRaw) throw new Error('No auth token');

    const token = tokenRaw.replace('Bearer', '').trim();
    const data: any = jwt.verify(token, process.env.JWT_ACCESS_TOKEN || KEY);

    const user = await GetUserWhere({
      _id: data?.uid,
    });

    if (!user) throw new Error('Invalid user');

    req.user = user;
    req.token = token;

    next();
  } catch (error) {
    next(error.message);
  }
}
