node {
    withAWS(credentials: 'aws-demo-credential', region: 'us-east-1') {
        ansiColor('xterm') {
            checkout()
            hello()
            loadConfig()
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

def loadConfig() {
    stage('Load config') {
        dir ("cicd") {
            jenkinsfile_utils = load 'Jenkinsfile.utils.groovy'
            jenkinsfile_utils.test(hello())
        }
    }
}

def init() {
    stage('Init') {
        dir ("dev") {
            sh 'ls && whoami'
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

def hello() {
    def log_test

    stage('Helloo') {
        dir ("dev") {
            log_test = sh 'echo Duma'
        }
    }

    return log_test
}
