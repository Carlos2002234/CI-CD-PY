pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                git 'https://github.com/Carlos2002234/proyectoCICD.git'
            }
        }
        stage('Build Docker image') {
            steps {
                script {
                    docker.build('flask-app')
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    docker.image('flask-app').inside {
                        // Add the parent directory of proyectoCICD to the Python path
                        sh 'export PYTHONPATH=$PWD/../ && pytest tests/'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.run('flask-app', '-p 5000:5000')
                }
            }
        }
    }
}
