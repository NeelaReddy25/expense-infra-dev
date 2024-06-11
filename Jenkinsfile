pipeline {
    agent {
        label 'AGENT-1'
    }
    options {
        timeout (time:30, unit: 'MINUTES')
        disableConcurrentBuilds()
        ansiColor('xterm')
    }
    stages {
        stage ('init') {
            steps {
                sh """
                cd 01-vpc
                terraform init -reconfigure
                """
            }
        }
        stage ('plan') {
            steps {
                sh """
                cd 01-vpc
                terraform plan
                """
            }
        }
        
        input {
            message "should we continue?"
            ok "yes,we should."
        }
        stage ('Deploy') {
            steps {
                sh """
                cd 01-vpc
                terraform apply -auto-approve
                """
            }
        }
    }
    post {
        always {
            echo 'I will always say Hello again!'
            deleteDir()
        }
        success {
            echo 'I will run when pipeline is success'
        }
        failure {
            echo 'I will run when pipeline is failure'
        }
    }
}