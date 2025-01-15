#forsyth barr specific aliases

function setup_codeartifact_creds() {
    aws codeartifact login --tool=pip --domain tooling --repository serving
    export POETRY_HTTP_BASIC_TROVE_USERNAME=aws
    export POETRY_HTTP_BASIC_TROVE_PASSWORD=$(aws codeartifact get-authorization-token --domain-owner 335433835758 --domain tooling --query 'authorizationToken' --output text)
}

alias py-auth=setup_codeartifact_creds

