 param (
    [string]$UPLOAD_FOLDER,
	[string]$REMOTE_PATH,
	[string]$LOG_FILENAME
 )

#rclone move $UPLOAD_FOLDER $REMOTE_PATH$UPLOAD_FOLDER --progress --delete-after --drive-chunk-size 128M --buffer-size 256M --transfers 8 | tee $LOG_FILENAME

rclone move "$UPLOAD_FOLDER" "$REMOTE_PATH" --progress --delete-after --drive-chunk-size 64M --buffer-size 128M --transfers 8 | tee "$LOG_FILENAME"

#Remove empty folder
rclone rmdirs "$UPLOAD_FOLDER" --leave-root