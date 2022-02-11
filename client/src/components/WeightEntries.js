import WeightEntry from './WeightEntry'

const WeightEntries = ({ weightHistory, onDelete, onUpdate }) => {
  return (
    <>
      {weightHistory.map((weightEntry, index) => (
        <WeightEntry key={index} weight={weightEntry} onDelete={onDelete} onUpdate={onUpdate} />
      ))}
    </>
  )
}

export default WeightEntries
