# Setting up a new Pi from scratch
1. Download the latest [Raspbian Stretch Lite] image, and unzip the downloaded
   file.

[Raspbian Stretch Lite]: https://www.raspberrypi.org/downloads/raspbian/

1. Connect the SD card for the Pi to your computer. Unmount the drive if it is
   mounted automatically, and determine the device path of your SD card using
   `lsblk` or a similar tool that shows device names.

   Use the device's name without any partition numbers, so for instance
   `/dev/sdc` instead of `/dev/sdc2`.

    ```console
    $ export SD_CARD_DEVICE=/dev/??? # Fill in your own device!
    ```

1. Write the downloaded image to your SD card.

   **Warning! This step will erase all data on the device that you've chosen.
   Be very sure that you're using the correct device, and that you don't care
   about any data left on the target device.**

    ```console
    $ sudo dd if=*-raspbian-stretch-lite.img of=$SD_CARD_DEVICE bs=4M status=progress; sync
    ```

1. Remove the SD card and boot the Pi. You'll need to connect the Pi with an
   Ethernet cable to run the playbook for the first time, as there won't be
   any network connections present.

   Log in using the default credentials (`pi`, `raspberry`) and execute the
   following commands:

    ```console
    $ sudo systemctl enable --now ssh
    $ ip addr
    ```

    You should now be able to access the Pi over SSH. Adjust the `hosts` file
    for the playbook to contain the correct IP.

1. Open the `ansible` directory, and retrieve a Github token. This is needed to
   retrieve the SSH keys.

    ```console
    $ cd ansible
    $ ./scripts/authorize-github.sh
    Please enter your Github username:
    maartenberg
    Please enter an one-time password, if required, else just press enter.
    123456
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100   313  100   269  100    44    567     92 --:--:-- --:--:-- --:--:--   660
    Got token: [secret]
    Token saved!
    ```

   You can now build the file with authorized keys:

    ```console
    $ ./scripts/get-authorized-keys.sh
    Creating .new-authorized-keys.
    Retrieving users for team 534284.
    Retrieving keys for ...
    Retrieving users for team 553592.
    Retrieving keys for ...
    Updating authorized-keys template.
    Done!
    ```

1. Execute the playbook using the following command:

    ```console
    $ cd ansible
    $ ./scripts/run-playbook.sh --ask-pass main.yml
    ```

   Enter `raspberry` as the password.

Your Pi is now ready for use! Reboot the Pi using SSH or `ansible -i hosts -m
reboot all`, and your chosen website should open.

<!-- vim: set et sw=4 softtabstop=4: -->
