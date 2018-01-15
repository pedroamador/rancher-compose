#!groovy

pipeline {
    agent none

    stages {
        stage ('Test') {
            agent { label 'docker' }
            steps  {
                sh 'bin/test.sh'
            }
        }
    }
}