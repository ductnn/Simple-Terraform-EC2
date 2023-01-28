jenkinsfile_utils = load 'Jenkinsfile.utils.groovy'

node {
    withAWS(credentials: 'aws-demo-credential', region: 'us-east-1') {
        ansiColor('xterm') {
            checkout()
            init()
            lint()
            plan()
        }
    }
}

def checkout() {
    stage('Clone') {
        // git branch: 'master', url: 'https://github.com/ductnn/Simple-Terraform-EC2.git'
        checkout scm
    }
}

def init() {
    stage('Init') {
        dir ("dev") {
            sh 'ls && whoami'
            jenkinsfile_utils.test "ls && whoami"
            sh 'terraform init'
        }
    }
}

def lint() {
    stage('Lint') {
        dir ("dev") {
            sh 'terraform fmt'
            sh 'terraform validate'
        }
    }
}

def plan() {
    stage('Plan') {
        dir ("dev") {
            sh 'terraform plan'
            sh 'printenv'
        }
    }
}
