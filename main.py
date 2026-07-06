from fastapi import FastAPI
from pydantic import BaseModel

class Task(BaseModel):
      title: str
      done: bool = False

app = FastAPI()

@app.get("/")
def root():
    return {"status": "ok"}

@app.get("/health")
def health():
    return {"status": "healthy", "version": "1.0"}
tasks = [
   {"id": 1, "title": "learn Docker", "done": False},
   {"id": 2, "title": "configurate CI/CD", "done": False},
]

@app.get("/tasks")
def get_tasks():
    return tasks

@app.post("/tasks")
def create_task(task: Task):
    new_id = len(tasks) + 1
    new_task = {"id": new_id, "title": task.title, "done": task.done}
    tasks.append(new_task)
    return new_task

@app.get("/tasks/{task_id}")
def get_task(task_id: int):
    for task in tasks:
        if task["id"] == task_id:
            return task
@app.delete("/tasks/{task_id}")
def delete_task(task_id: int):
    for task in tasks:
        if task["id"] == task_id:
            tasks.remove(task)
            return {"message": "deleted"}
