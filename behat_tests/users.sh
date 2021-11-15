#!/bin/bash
help=n
delete_previous=n
create_users=n

IFS=$'\n' read -r -d '' -a var_roles < <(drush rls --format list && printf '\0')
delete=anonymous
var_roles=("${var_roles[@]/$delete/}") #Quotes when working with strings

# options
while getopts cdh opt; do
  case "${opt}" in
  c)
    echo "==> create users per role   <==" >&2
    create_users=y
    ;;
  d)
    echo "==> delete users            <==" >&2
    delete_previous=y
    ;;
  h)
    help=y
    ;;
  \?)
    help=y
    ;;
  esac
done
shift $((OPTIND - 1))

# logic
if [ ${help} = 'y' ]; then
  echo "===========================================" >&2
  echo ""
  echo "HELP:" >&2
  echo ""
  echo "  -c)   create users per role"
  echo "  -d)   delete users per role"
  echo "  -h)   print this help"
  echo ""
  echo "==========================================="
  exit
fi

if [ ${delete_previous} = 'y' ]; then
  echo "====> DELETING:"
  for role in ${var_roles[@]}; do
    printf "=> ${role}_test: "
    drush ucan ${role}_test --delete-content -y &>/dev/null
    echo "deleted"
  done
fi

if [ ${create_users} = 'y' ]; then
  echo "====> CREATING:"
  for role in ${var_roles[@]}; do
    echo "=> ${role}_test: created"
    drush ucrt ${role}_test 2>/dev/null
    drush upwd ${role}_test test 2>/dev/null
    drush urol ${role} ${role}_test 2>/dev/null
    # drush uli --name=${role}_test
  done
fi
