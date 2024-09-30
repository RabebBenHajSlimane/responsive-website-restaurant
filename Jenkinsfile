pipeline {
    agent none  // Aucune machine par défaut, car on spécifie un agent externe
    stages {
        stage('Clone Repository') {
            agent { label 'Ubuntu-VM-Agent' } // Remplacez par le nom de votre agent Jenkins configuré sur la VM Ubuntu
            steps {
                script {
                    // S'assurer que l'installation Git est utilisée
                    tools {
                        git 'Default' // Utiliser l'installation Git configurée
                    }
                    // Clone le dépôt GitHub
                    git 'https://github.com/RabebBenHajSlimane/responsive-website-restaurant.git'  // Remplacez par l'URL de votre dépôt GitHub
                }
            }
        }
        stage('Build Docker Image') {
            agent { label 'Ubuntu-VM-Agent'}
            steps {
                script {
                    // Construire l'image Docker à partir du Dockerfile
                    sh 'docker build -t 141119988/my-image:latest .' // Assurez-vous que le chemin est correct
                }
            }
        }
        stage('Push Docker Image') {
            agent { label 'Ubuntu-VM-Agent' }
            steps {
                script {
                    // (Optionnel) Se connecter à Docker Hub
                    sh 'docker login -u 141119988 -p doudi1411 '
                    
                    // Pousser l'image Docker sur Docker Hub
                    sh 'docker push 141119988/my-image:latest'
                }
            }
        }
        stage('Deploy to Kubernetes') {
            agent { label 'Ubuntu-VM-Agent' }
            steps {
                script {
                    // Déployer l'application sur Kubernetes
                    // Assurez-vous que votre fichier de configuration Kubernetes est prêt (par exemple, deployment.yaml)
                    sh 'kubectl apply -f my-app-deployment.yaml'  // Remplacez par le chemin vers votre fichier de configuration si nécessaire
                }
            }
        }
    }
}
