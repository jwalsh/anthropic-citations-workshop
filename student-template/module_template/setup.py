"""Template module setup."""

from setuptools import setup, find_packages

setup(
    name="student-module",
    version="0.1.0",
    packages=find_packages(),
    install_requires=[
        "anthropic>=0.8.0",
        "pandas>=2.0.0",
    ],
)
