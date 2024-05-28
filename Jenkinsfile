pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                git 'https://github.com/Carlos2002234/CI-CD-PY.git'
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
                        sh 'pytest tests/' // Run tests using pytest from the 'tests' directory
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
