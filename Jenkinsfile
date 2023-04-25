node {
    def buildNumber = env.BUILD_NUMBER
    stage ("Git Checkout") {
        git url: 'https://github.com/joeprakash15/php-nginx-project.git', branch: 'master'
    }
    stage ("Docker image build") {
        sh "docker build -t joeprakashsoosai/php-project:${buildNumber} ."
    }
    stage ("Push to Dockerhub"){
        withCredentials([string(credentialsId:'Docker_hub_pass', variable:'Docker_hub_pass')]) {
            sh "docker login -u joeprakashsoosai -p ${Docker_hub_pass}"
            sh "docker push joeprakashsoosai/php-project:${buildNumber}"
        }
    }
    stage ("Php application Deployment") {
        sh "docker rm -f php-demo || true"
        sh "docker run -d -p 8006:80 --name php-demo joeprakashsoosai/php-project:${buildNumber}"
    }
    stage('Example') {
        def remoteServer = '35.78.115.235'
        def remoteUser = 'ubuntu'
        def remoteContainerName = 'php-demo'

        // Check if the Docker container is running
        def isRunning = sh(
            script: "docker ps -f name=${remoteContainerName} -q | wc -l",
            returnStdout: true
        ).trim().toInteger() > 0

        if (isRunning) {
            sh "docker rm -f  ${remoteContainerName}"
            sh "docker run -d -p 8007:80 --name ${remoteContainerName} joeprakashsoosai/php-project:${buildNumber}"
        } else {
            echo "Container is not healthy. Exiting..."
        }
    }
}
