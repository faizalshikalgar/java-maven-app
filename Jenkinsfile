#!/usr/bin/env groovy

@Library ('shared-libs')
def gv
pipeline{
    agent any
    tools{
        maven 'Maven'
    }
    stages{
        stage("init"){
            steps {
                script {
                    gv = load "script.groovy"
                }
            }
        }
        stage("Build jar"){
            steps{
                script {
                  buildJar()
                }
            }    
        }
        stage("build image"){
            steps{
                script {
                    buildIamge()
                }        
            }    
        }
        stage("Deploy"){
            steps{
                script {
                  gv.deployApp()
                }
            }    
        }
        
    }
}
