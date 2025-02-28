**Feature**: Tagging a Question as Resolved/Unresolved \
**Description**: This feature allows users with the necessary privileges to mark a forum topic as resolved or unresolved. \
**Steps to Use**:
1. Navigate to the topic you want to mark as resolved.
2. OP and admin (teachers/instructors) can use the tag feature and type in “resolved” into the field to indicate that a question has been resolved.
3. OP and admin can remove the resolved tag if a question turns out to be unresolved

**Expected Behavior**:
- A notification is sent to the topic owner when the status changes.
- The topic is updated in the database with the correct resolved status.
- A new tag is added in the main page next to the topic indicating that it is now “resolved.”
- Users can search and sort for resolved questions the same way as any other tag.
- Unauthorized users should receive a 403 Forbidden error if they attempt to change the status (shouldn’t be accessible anyways).
- If the topic does not exist, a 404 Not Found response should be returned (shouldn’t be accessible anyways).

**Test Location**: test/topics.js \
**What is Being Tested?**
- Database Updates - Ensures that the resolved status is correctly stored and updated.
- Permission Checks - Validates that unauthorized users cannot update the topic status.
- Non-existent Topics - Ensures that marking a missing topic results in a 404 error.
**Why These Tests Are Sufficient**:
- They cover all primary use cases and edge cases.
- They verify expected system behaviors (status updates, errors).
- They ensure security by checking user permissions.
- They prevent regressions by automating the verification of existing functionality.
- No added testing was done for searching/sorting by tag, as that should be all built in through the existing tagging feature which was not changed.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Feature**: Notifications sent out when a Question is marked as resolved/unresolved \
**Description**: OP and users watching the post receive a notification when the topic is marked as resolved or unresolved. \
**Steps to Use**:
1. Whenever a question is marked as resolved/unresolved, OP and all users watching the post receive a notification notifying them that the question has been resolved.

**Expected Behavior**:
- Notification is only sent out to OP and those watching the topic.
- Notification should be sent out once for each time the topic is marked as resolved/unresolved.

**Test Location**: test/topics.js \
**What is Being Tested?**
- Notifications - Verifies that notifications are sent to the correct users.
- Makes sure that notifications are only called once

**Why These Tests Are Sufficient**:
- Relatively simple feature, as long as correct users receive the notification and are not spammed, not any other edge cases.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Feature**: Filtering for unanswered questions \
**Description**: This feature allows users with the necessary privileges (instructors and TAs) to filter for unanswered forum topics. Students or guest users cannot access the unanswered topics filter. \
**Steps to Use**: \
**(API way)**
1. On a local instance of NodeBB, create a user and give them admin privileges with redis-cli SADD administrators [uid]
2. Ensure NodeBB is started.
3. Generate an API key in NodeBB → Settings → API Access
4. Run the command curl -X GET "http://localhost:4567/api/topics/unanswered?uid=[UID GOES HERE]" -H "Authorization: Bearer [API KEY]"

Sample Test:
curl -X GET "http://localhost:4567/api/topics/unanswered?uid=1" -H "Authorization: Bearer f0923db3-738b-45c7-9f75-6015fae371c5"

**(UI way)**
1. Navigate to the category you want to see the topics of.
2. OP and admin (teachers/instructors) can click on the unanswered question button next to the recently replied filter button in the bar above the topic lists.
3. OP and admin can now see only the unanswered topics (have no replies).

**Expected Behavior**:
- An unanswered question button is added to the bar above the lists of topics.
- Instructors and TAs (administrators) can view unanswered questions by clicking on the unanswered question button.
- Unauthorized users (students, guests) should receive a console log error if they attempt to access the filter.
- If no unanswered topics exist, the system returns an empty array. 
- If the requested topics do not exist, a 404 Not Found error is returned (shouldn't be accessible). 
- The filter query should correctly return topics with only one post (postcount === 1).

**Test Location**: test/controllers.js & test/topics.js \
**What is Being Tested?**
- Database Queries - Ensures that only topics with postcount === 1 are returned.
- Permission Checks - Validates that only instructors and TAs can filter unanswered questions.
- Handling Empty Results: Confirms that an empty array is returned when there are no unanswered questions. 
- Error Handling: If a user lacks permission, return a 403 Forbidden. If the requested topics don’t exist, return a 404 Not Found.

**Why These Tests Are Sufficient**:
- They cover all use cases - ensures that only unanswered topics are fetched.
- They validate security - prevents unauthorized users from accessing the filter
- They prevents regressions - automates verification of access control and query behavior.
- Error handling is tested - Ensures 403 and 404 errors are returned when appropriate. 
- No additional testing was done for sorting unanswered topics, as the system already handles sorting via the existing topic retrieval methods.
