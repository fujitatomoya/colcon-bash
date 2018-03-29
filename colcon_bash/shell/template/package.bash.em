# generated from colcon_bash/shell/template/package.bash.em

# function to source another script with conditional trace output
# first argument: the name of the script file
# additional arguments: arguments to the script
colcon_package_source_bash_script() {
  # arguments
  _colcon_package_source_bash_script="$1"

  # source script with conditional trace output
  if [ -f "$_colcon_package_source_bash_script" ]; then
    if [ -n "$COLCON_TRACE" ]; then
      echo ". \"$_colcon_package_source_bash_script\""
    fi
    . $@@
  else
    if [ -n "$COLCON_TRACE" ]; then
      echo "not found: \"$_colcon_package_source_bash_script\""
    fi
  fi

  unset _colcon_package_source_bash_script
}


# a bash script is able to determine its own path
# the prefix is two levels up from the package specific share directory
COLCON_CURRENT_PREFIX=$(builtin cd "`dirname "${BASH_SOURCE[0]}"`/../.." > /dev/null && pwd)

colcon_package_source_bash_script "$COLCON_CURRENT_PREFIX/share/@(pkg_name)/package.sh"

@[for i, hook in enumerate(hooks)]@
@[  if i == 0]@
COLCON_CURRENT_PREFIX=$(builtin cd "`dirname "${BASH_SOURCE[0]}"`/../.." > /dev/null && pwd)

@[end if]@
colcon_package_source_bash_script "$COLCON_CURRENT_PREFIX/@(hook[0])"@
@[  for hook_arg in hook[1]]@
 @(hook_arg)@
@[  end for]
@[end for]@
@[if hooks]@

unset COLCON_CURRENT_PREFIX
@[end if]@
unset colcon_package_source_bash_script
