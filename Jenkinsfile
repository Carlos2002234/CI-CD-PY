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
                        // SSH credentials ID from Jenkins credentials store
                        def sshCredentialsId = 'ec2-user'

                        // SSH into the server and run deployment commands
                        sshagent([sshCredentialsId]) {
                            sh """
                                ssh -o StrictHostKeyChecking=no ec2-user@18.212.202.207 <<EOF
                                docker pull flask-app
                                docker stop flask-app || true
                                docker rm flask-app || true
                                docker run -d -p 5000:5000 --name flask-app flask-app
                                EOF
                            """
                        }
                    } catch (err) {
                        currentBuild.result = 'FAILURE'
                        error "Failed to deploy: ${err}"
                    }
                }
            }
        }
    }
}