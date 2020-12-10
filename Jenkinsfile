pipeline {
    agent any
    tools {
        "org.jenkinsci.plugins.terraform.TerraformInstallation" "terraform"
    }

    environment {
        TF_HOME = tool('terraform')
        TF_INPUT = "0"
        TF_IN_AUTOMATION = "TRUE"
        TF_LOG = "WARN"
        AWS_ACCESS_KEY_ID = credentials('aws_access_key')
        AWS_SECRET_ACCESS_KEY = credentials('aws_secret_access_key')
        PATH = "$TF_HOME:$PATH"
    }

    stages {
        stage('WiproTestInit'){
            steps {
                {
                    sh 'terraform --version'
                    sh "terraform init"
                }
            }
        }
        stage('WiproTestValidate'){
            steps {
                {
                    sh 'terraform validate'
                }
            }
        }
        stage('WiproTestPlan'){
            steps {
                {
                    sh "terraform plan -out wipro-dev-test.tfplan;echo \$? > status"
                    stash name: "wipro-dev-test", includes: "wipro-dev-test.tfplan"
                }
            }
        }
        stage('WiproTestApply'){
            steps {
                script{
                    def apply = false
                    try {
                        input message: 'confirm apply', ok: 'Apply Config'
                        apply = true
                    } catch (err) {
                        apply = false
                        {
                            sh "terraform destroy -auto-approve"
                        }
                        currentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                        {
                            unstash "wipro-dev-test"
                            sh 'wipro-dev-test.tfplan'
                        }
                    }
                }
            }
        }

    }
}