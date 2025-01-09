pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/bhavika2001/student_management.git'
        GIT_BRANCH = 'main'
        GITHUB_TOKEN = credentials('github-token') // Reference the secure GitHub token from Jenkins credentials
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Clone the repository using the GitHub token for authentication
                    sh """
                    git clone -b ${GIT_BRANCH} https://${GITHUB_TOKEN}@github.com/bhavika2001/student_management.git
                    """
                }
            }
        }

        stage('Build Application') {
            steps {
                script {
                    // Run Maven build to package the application
                    bat './mvnw clean package -DskipTests'
                }
            }
        }

        stage('Run Application Locally') {
            steps {
                script {
                    // Run the generated JAR file (replace 'sh' with 'bat' for Windows)
                    bat 'start java -jar target/*.jar > app.log 2>&1'
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
