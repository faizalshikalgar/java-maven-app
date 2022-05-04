#!/usr/bin/env groovy

pipeline{
    agent any
    tools{
        maven 'Maven'
    }
    stages{
        stage("increment version"){
            steps{
                script {
                  echo "incrementing app version..."
                  sh 'mvn build-helper:parse-version versions:set \
                    -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nestIncrementalVersion} \
                    versions:commit'
                  def matcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                  def version = matcher[0][1]
                  env.IMAGE_NAME = "$version-$BUILD_NUMBER"
                }
            }    
        }
        stage("Build app"){
            steps{
                script {
                  echo "building the application"
                  sh "mvn clean package"
                }
            }    
        }
        stage("build image"){
            steps{
                script {
                    echo "building the docker image..."
                    withCredentials([usernamePassword(credentialsId: 'deocker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "docker build -t faizalshikalgar/demo-app:${IMAGE_NAME} ."
                        sh "echo $PASS | docker login -u $USER -password-stdin"
                        sh "docker push faizalshikalgar/demo-app:${IMAGE_NAME}"
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
