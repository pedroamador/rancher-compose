#!/usr/bin/env bash

default_out=`tput sgr0` # white

describe () {
    local msg info_out
    msg=$1
    info_out=`tput setaf 3` # yellow
    echo "${info_out} $msg${default_out}"
}

describe_suite(){
    local msg info_out
    msg=$@
    info_out=`tput setaf 6` # blue
    echo "${info_out}$msg${default_out}"   
}

describe_success(){
    local msg success_out
    msg=$1
    success_out=`tput setaf 2` # green
    echo "${success_out}  $msg${default_out}"
}

describe_failure(){
    local msg failure_out
    msg=$1
    failure_out=`tput setaf 1` # red
    echo "${failure_out}  $msg${default_out}"
}

destroy_container(){
  local container destroy 
  container=$1  
  destroy=$(docker rm -f $container)
  echo $destroy
}

should() {
    local  container is_success msg 
    container=$1
    is_success=$2
    msg=$3

    if [[ "$is_success" = "0" ]]; then
        describe_success "Successful: $msg"
    else
        describe_failure "Fail: $msg"
        destroy_container $container
        exit 1
    fi
}

example_test() {
    echo 0
}

main() {
    local container
    container="SOME_ID"

    describe_suite "example suite" 

        describe "example"
            should $container $(example_test $container) "example test ok"

    describe_suite "container destroyed" $(destroy_container $ubuntu_dind)

    exit 0
}

main "$@"