pipeline {
    agent { label 'vinod' }
    stages {
        stage("git checkout") {
            steps {
                git branch: 'main', url: 'https://github.com/Rutvikgalale/django-notes-app.git'
            }
        }
        stage("code build") {
            steps {
                sh 'docker build -t notes-app:latest .'
            }
        }
        stage("push image to Dockerhub") {
            steps {
                withCredentials([usernamePassword(credentialsId: "DockerHubcred", passwordVariable: "DockerHubPass", usernameVariable: "DockerHubUser")]) {
                    sh "docker login -u ${env.DockerHubUser} -p ${env.DockerHubPass}"
                    sh "docker image tag notes-app:latest ${env.DockerHubUser}/notes-app:latest"
                    sh "docker push ${env.DockerHubUser}/notes-app:latest"
                }
            }
        }
        stage("code Deploy") {
            steps {
                sh '''
                old=$(docker ps -aq --filter "publish=8000")
                if [ -n "$old" ]; then
                    docker stop $old || true
                    docker rm $old || true
                fi
                docker run -dit -p 8000:8000 notes-app:latest
                '''
            }
        }
    }
}
