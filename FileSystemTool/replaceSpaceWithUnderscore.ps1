Get-ChildItem -Exclude *.bat,*.ps1 | Rename-Item �VNewName { $_.name �Vreplace �� ��,��_�� }