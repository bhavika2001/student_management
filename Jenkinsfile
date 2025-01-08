pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/bhavika2001/student_management.git'
        GIT_BRANCH = 'main'
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    // Clone the repository using Git credentials
                    git credentialsId: 'github-credentials', branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
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
                    // Run the generated JAR file (replace 'sh' with 'bat')
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
