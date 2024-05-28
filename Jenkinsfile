pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                script {
                    try {
                        git url: 'https://github.com/Carlos2002234/CI-CD-PY.git'
                    } catch (err) {
                        currentBuild.result = 'FAILURE'
                        error "Failed to clone repository: ${err}"
                    }
                }
            }
        }
        stage('Build Docker image') {
            steps {
                script {
                    try {
                        docker.build('flask-app')
                    } catch (err) {
                        currentBuild.result = 'FAILURE'
                        error "Failed to build Docker image: ${err}"
                    }
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    try {
                        docker.image('flask-app').inside {
                            sh 'export PYTHONPATH=$PWD && pytest tests/'
                        }
                    } catch (err) {
                        currentBuild.result = 'FAILURE'
                        error "Failed to run tests: ${err}"
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    try {
                        docker.run('flask-app', '-p 5000:5000')
                    } catch (err) {
                        currentBuild.result = 'FAILURE'
                        error "Failed to deploy: ${err}"
                    }
                }
            }
        }
    }
}
