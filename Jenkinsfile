def gv
pipeline{
    agent any
    tools{
        maven 'Maven'
    }
    stages{
        stage("Build app"){
            steps{
                script {
                  echo "building the application"
                  sh "mvn package"
                }
            }    
        }
        stage("build image"){
            steps{
                script {
                    echo "building the docker image..."
                    withCredentials([usernamePassword(credentialsId: 'deocker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "docker build -t faizalshikalgar/demo-app:jma-2.0 ."
                        sh "echo $PASS | docker login -u $USER -password-stdin"
                        sh "docker push faizalshikalgar/demo-app:jma-2.0"
                    }
                }        
            }    
        }
        stage("Deploy"){
            steps{
                script {
                    echo "deploying the application..."
                }
            }    
        }
        
    }
}
