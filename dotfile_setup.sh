#source: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
#call me with:
#curl -Lks https://raw.githubusercontent.com/hyun007/random_scripts/master/dotfile_setup.sh | /bin/bash
git clone --bare https://github.com/hyun007/dotfiles.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup/.ssh
mv .ssh/config .config-backup/.ssh
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
