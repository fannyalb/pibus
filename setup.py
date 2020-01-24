# from
# https://packaging.python.org/guides/distributing-packages-using-setuptools
from os import path
from setuptools import setup, find_packages

HERE = path.abspath(path.dirname(__file__))

# Get the long description from the README file
with open(path.join(HERE, 'README.md'), encoding='utf-8') as f:
    LONG_DESCRIPTION = f.read()


setup(
    # This is the name of your project
    # Project can be installed with
    # $ pip install pibus
    name='pibus',
    # Verison
    # Versioning scheme
    # 1.2.0.dev1  # Development release
    # 1.2.0a1     # Alpha Release
    # 1.2.0b1     # Beta Release
    # 1.2.0rc1    # Release Candidate
    # 1.2.0       # Final Release
    # 1.2.0.post1 # Post Release
    # 15.10       # Date based release
    # 23          # Serial release
    version='0.0.1',
    description='Raspberry Pi Car PC for Camper Bus',
    long_description=LONG_DESCRIPTION,
    long_description_content_type='text/markdown',
    url='https://github.com/fannyalb/pibus',
    author='Fanny Albrecht',
    license='MIT',

    classifiers=[
        # How mature is this project?
        # 3 - Alpha
        # 4 - Beta
        # 5 - Production/Stable
        'Development Status :: 1 - Alpha',

        'Intended Audience :: Everyone',
        'Topic :: Raspberry Pi :: Car',

        'Programming Language :: Python :: 3',
    ],
    keywords='raspberry carpc',
    project_url={},

    packages=find_packages(include=['pibus', 'pibus.*']),
    # py_modules=["six"],
    # install_requires=['peppercorn'],
    python_requires='>=3',



)
