pipeline {
    agent none  // Aucune machine par défaut, car on spécifie un agent externe
    stages {
        stage('Clone Repository') {
            agent { label 'Ubuntu-VM-Agent' }
            steps {
                script {
                    // Utiliser les informations d'identification pour cloner le dépôt privé
                    withCredentials([usernamePassword(credentialsId: 'github-credentials-id', passwordVariable: 'GITHUB_TOKEN', usernameVariable: 'GITHUB_USERNAME')]) {
                        // Cloner le dépôt GitHub
                        sh 'git clone https://$GITHUB_USERNAME:$GITHUB_TOKEN@github.com/RabebBenHajSlimane/responsive-website-restaurant.git'
                    }
                }
            }
        }
        stage('Build Docker Image') {
            agent { label 'Ubuntu-VM-Agent' }
            steps {
                script {
                    // Construire l'image Docker à partir du Dockerfile
                    sh 'docker build -t 141119988/my-image:latest .' 
                }
            }
        }
        stage('Push Docker Image') {
            agent { label 'Ubuntu-VM-Agent' }
            steps {
                script {
                    // Utiliser les informations d'identification Jenkins pour Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials-id', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        // Se connecter à Docker Hub
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                        
                        // Pousser l'image Docker sur Docker Hub
                        sh 'docker push 141119988/my-image:latest'
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            agent { label 'Ubuntu-VM-Agent' }
            steps {
                script {
                    // Déployer l'application sur Kubernetes
                    sh 'kubectl apply -f my-app-deployment.yaml'  
                }
            }
        }
    }
    post {
        success {
            // Notifications en cas de succès
            echo 'Pipeline succeeded!'
        }
        failure {
            // Notifications en cas d'échec
            echo 'Pipeline failed!'
        }
    }
}
