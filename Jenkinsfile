pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/bhavika2001/student_management.git'
        GIT_BRANCH = 'main'
        GITHUB_TOKEN = credentials('github-token') // Securely reference GitHub token
    }

    stages {
        stage('Clean Workspace') {
            steps {
                script {
                    // Remove existing directory if it exists
                    bat 'IF EXIST student_management (rmdir /S /Q student_management)'
                }
            }
        }

        stage('Clone Repository') {
            steps {
                script {
                    // Clone the repository securely
                    sh """
                    git clone -b ${GIT_BRANCH} https://$GITHUB_TOKEN@github.com/bhavika2001/student_management.git
                    """
                }
            }
        }

        stage('Build Application') {
            steps {
                script {
                    // Build the application using Maven
                     bat 'mvnw.cmd clean package -DskipTests'
                }
            }
        }

        stage('Run Application Locally') {
            steps {
                script {
                    // Start the application
                    bat 'start java -jar target/student-management-system-0.0.1-SNAPSHOT.jar > app.log 2>&1'
                }
            }
        }
    }

    post {
        success {
            echo 'Application deployed locally and running on http://localhost:8080!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
