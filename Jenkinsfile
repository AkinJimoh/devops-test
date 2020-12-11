pipeline {
    agent any
        tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }

    environment {
        registry = "ak11in/wipro"
        registryCredential = 'docker-creds'
        TF_HOME = tool('terraform')
        TF_INPUT = "0"
        TF_IN_AUTOMATION = "TRUE"
        TF_LOG = ""
        AWS_ACCESS_KEY_ID = credentials('aws_access_key')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        PATH = "$TF_HOME:$PATH"
    }

    stages {
        stage('Wipro-TF-Init') {
            steps {
                sh '''
                    terraform -version
                    terraform init
                '''
            }
        }
        stage('Wipro-TF-Validate') {
            steps {
                sh '''
                    terraform validate
                '''
            }
        }
        stage('Wipro-TF-Plan') {
            steps {
                    sh "terraform plan -out wipro-dev-test.tfplan;echo \$? > status"
                    stash name: "wipro-dev-test", includes: "wipro-dev-test.tfplan"
            }
        }
        stage('ApplicationApply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'confirm apply', ok: 'Apply Config'
                        apply = true
                    } catch (err) {
                        apply = false

                            sh "terraform destroy -auto-approve"
                            
                        currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){

                            unstash "wipro-dev-test"
                            sh 'terraform apply wipro-dev-test.tfplan'
                            
                    }
                }
            }
        }
    }
}