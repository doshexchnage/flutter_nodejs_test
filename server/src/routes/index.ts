import AuthRouter from './auth.route';
import WeightRouter from './weights.route';

export default function AppRouter(app) {
  app.use('/auth', AuthRouter);

  app.use('/weights', WeightRouter);
}
