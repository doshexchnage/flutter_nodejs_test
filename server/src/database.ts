import { connect } from 'mongoose';

const connectionString =
  process.env?.CONNECTION_STRING || 'mongodb://localhost:27017/test';

export default async function SetupDatabase() {
  await connect(connectionString, () => console.log('Database connected'));
}
