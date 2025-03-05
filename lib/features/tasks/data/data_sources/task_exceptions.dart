class TaskServiceException implements Exception {
  const TaskServiceException();
}

// C in CRUD
class CouldNotCreateTaskException extends TaskServiceException {}

// R in CRUD
class CouldNotGetAllTasksException extends TaskServiceException {}

// U in CRUD
class CouldNotUpdateTaskException extends TaskServiceException {}

// D in CRUD
class CouldNotDeleteTaskException extends TaskServiceException {}