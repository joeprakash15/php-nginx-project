node {
    def buildNumber = env.BUILD_NUMBER
    stage ("Git Checkout") {
        git url: 'https://github.com/joeprakash15/php-nginx-project.git', branch: 'master'
    }
    stage ("Docker image build") {
        sh "docker build -t joeprakashsoosai/php-project:${buildNumber} ."
    }
    stage ("Push to Dockerhub"){
        withCredentials([string(credentialsId:'Docker_hub_pass', variable:'Dcoker_hub_pass')]) {
            sh "docker login -u joeprakashsoosai -p ${Docker_hub_pass}"
            sh "docker push joeprakashsoosai/php-project:${buildNumber}"
        }
    }
    stage ("Php application Deployment") {
        sh "docker rm -f php-demo1 || true"
        sh "docker run -d -p 8006:80 --name php-demo joeprakashsoosai/php-project:${buildNumber}"
    }
}
