pipeline{
    agent any
    tools{
        maven 'Maven'
    }
    stages{
        stage("Build jar"){
            steps{
                script {
                  echo "Building the application..."
                  sh 'mvn package'
                }
            }    
        }
        stage("build image"){
            steps{
                script {
                    echo "Building the docker image..."
                    withCredentials([usernamePassword(credentialsId: 'docker-hubrepo', passwordVariable: 'PASS' usernameVariable: 'USER')]) {
                        sh 'docker build -t faizalshikalgar/demo-app:jma-2.0 .'
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh 'docker push faizalshikalgar/demo-app:jma-2.0'
                    }
                }        
            }    
        }
        stage("Deploy"){
            steps{
                script {
                  echo "Deploying the application..."
                }
            }    
        }
        
    }
}
