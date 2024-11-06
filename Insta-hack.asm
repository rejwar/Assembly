.data
username: .asciiz "your_username"
password: .asciiz "your_password"
login_url: .asciiz "https://www.instagram.com/accounts/login/"
followers_url: .asciiz "https://www.instagram.com/%s/followers/"
following_url: .asciiz "https://www.instagram.com/%s/following/"
unfollow_url: .asciiz "https://www.instagram.com/web/friendships/%s/unfollow/"

.text
.globl main
main:
    # Login to Instagram
    la $a0, username
    la $a1, password
    jal login
    move $s0, $v0

    # Get followers
    la $a0, username
    jal get_followers
    move $s1, $v0

    # Get following
    la $a0, username
    jal get_following
    move $s2, $v0

    # Get unfollowers
    move $a0, $s1
    move $a1, $s2
    jal get_unfollowers
    move $s3, $v0

    # Unfollow unfollowers
    move $a0, $s0
    move $a1, $s3
    jal unfollow_users

    # Exit
    li $v0, 10
    syscall

login:
    # Implement login functionality
    # Return session in $v0
    jr $ra

get_followers:
    # Implement getting followers functionality
    # Return list of followers in $v0
    jr $ra

get_following:
    # Implement getting following functionality
    # Return list of following in $v0
    jr $ra

get_unfollowers:
    # Implement getting unfollowers functionality
    # Return list of unfollowers in $v0
    jr $ra

unfollow_users:
    # Implement unfollowing users functionality
    jr $ra
