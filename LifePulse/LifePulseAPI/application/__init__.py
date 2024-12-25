import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from .routes import post, record, user
from .orm.database import Base, engine


def create_app(test_config=None):
    # create and configure the app
    app = FastAPI()

    """
    自动创建数据库表
    注意：如果表已经存在，则不会再创建，除非删除原来的表
    """
    Base.metadata.create_all(bind=engine)

    origins = [
        "http://127.0.0.1:3000",
        "http://localhost:3000"
    ]
    app.add_middleware(
        CORSMiddleware,
        allow_origins=origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    app.include_router(user.router)
    app.include_router(post.router)
    app.include_router(record.router)

    # a simple page that says hello
    @app.get("/hello")
    def hello():
        return "Hello, World!"

    return app
