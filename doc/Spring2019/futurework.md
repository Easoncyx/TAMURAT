# Future work of TAMURAT

1. Concurrent operation: not all the operation have been optimized for concurrent operation. For example, a user might editing one resource while another attempt to delete it.
2. Administritor invitation security issue: currently, the admin and invite another admin whos password is generate randomly. As long as they click the link in the activation email, they will be loged in without any check. If the email was hijack or send to someone else, the system is at risk.
3. The initial setup: In this app, the initial administrator setup is through `seed` operation from rails. It's better to do a setup page for this system.
4. Better visual hints: We can have a red font for those quesitions that haven't been answered or those weight of the questions is set to 0.
5. Calculating the score: the score of unvalidated answer is calculated as long as the `finalize` button is clicked.
6. Import a zip file into the system for answering the questions and all the evidences needed for the system.

