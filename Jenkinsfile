pipeline {
	agent any
	triggers { pollSCM('*/1 * * * *') }

	environment {
         branch = env.BRANCH_NAME.replaceAll(/.*\//,"").toLowerCase().take(8)
   	}

	stages {
		stage('init') {
                  steps {
		     sh "echo $branch"
		  }
		}		
		stage('checkout') {
			steps {
				checkout scm
			}
		}
        	stage('btrfs snapshot') {
            		steps {
               			sh 'btrfs version'
               			sh '(test -e /mnt/btrfs/pg-$branch && btrfs subvolume delete /mnt/btrfs/pg-$branch) || true'
               			sh 'btrfs subvolume snapshot  /mnt/btrfs/pg-data-ref /mnt/btrfs/pg-$branch'
            		}
        	}
		stage('build & publish') {
			steps {
			    sh 'docker-compose kill && docker-compose rm -f'
			    sh 'docker-compose up -d'					
			}
		}
	}
}
