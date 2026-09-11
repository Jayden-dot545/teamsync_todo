/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:todolist_server/src/generated/todos/member_role.dart'
    as _iuyx70r3;
import 'package:todolist_server/src/generated/todos/todo_priority.dart'
    as _ia87hubl;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
import '../todos/todo_item_endpoint.dart' as _iu91y1px;
import '../todos/todo_list_endpoint.dart' as _iw2gkoqs;
import '../todos/todo_note_endpoint.dart' as _ic7eu8gt;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'todoItem': _iu91y1px.TodoItemEndpoint()
        ..initialize(
          server,
          'todoItem',
          null,
        ),
      'todoList': _iw2gkoqs.TodoListEndpoint()
        ..initialize(
          server,
          'todoList',
          null,
        ),
      'todoNote': _ic7eu8gt.TodoNoteEndpoint()
        ..initialize(
          server,
          'todoNote',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['todoItem'] = _is.EndpointConnector(
      name: 'todoItem',
      endpoint: endpoints['todoItem']!,
      methodConnectors: {
        'getItems': _is.MethodConnector(
          name: 'getItems',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoItem'] as _iu91y1px.TodoItemEndpoint)
                  .getItems(
                    session,
                    listId: params['listId'],
                  ),
        ),
        'createItem': _is.MethodConnector(
          name: 'createItem',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'dueDate': _is.ParameterDescription(
              name: 'dueDate',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'priority': _is.ParameterDescription(
              name: 'priority',
              type: _is.getType<_ia87hubl.TodoPriority>(),
              nullable: false,
            ),
            'assignedToUserId': _is.ParameterDescription(
              name: 'assignedToUserId',
              type: _is.getType<_is.UuidValue?>(),
              nullable: true,
            ),
            'assignedToName': _is.ParameterDescription(
              name: 'assignedToName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'subtasksJson': _is.ParameterDescription(
              name: 'subtasksJson',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'workSessionsJson': _is.ParameterDescription(
              name: 'workSessionsJson',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'recurrence': _is.ParameterDescription(
              name: 'recurrence',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoItem'] as _iu91y1px.TodoItemEndpoint)
                  .createItem(
                    session,
                    listId: params['listId'],
                    title: params['title'],
                    description: params['description'],
                    dueDate: params['dueDate'],
                    priority: params['priority'],
                    assignedToUserId: params['assignedToUserId'],
                    assignedToName: params['assignedToName'],
                    subtasksJson: params['subtasksJson'],
                    workSessionsJson: params['workSessionsJson'],
                    recurrence: params['recurrence'],
                  ),
        ),
        'updateItem': _is.MethodConnector(
          name: 'updateItem',
          params: {
            'itemId': _is.ParameterDescription(
              name: 'itemId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'dueDate': _is.ParameterDescription(
              name: 'dueDate',
              type: _is.getType<DateTime?>(),
              nullable: true,
            ),
            'priority': _is.ParameterDescription(
              name: 'priority',
              type: _is.getType<_ia87hubl.TodoPriority>(),
              nullable: false,
            ),
            'assignedToUserId': _is.ParameterDescription(
              name: 'assignedToUserId',
              type: _is.getType<_is.UuidValue?>(),
              nullable: true,
            ),
            'assignedToName': _is.ParameterDescription(
              name: 'assignedToName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'subtasksJson': _is.ParameterDescription(
              name: 'subtasksJson',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'workSessionsJson': _is.ParameterDescription(
              name: 'workSessionsJson',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'recurrence': _is.ParameterDescription(
              name: 'recurrence',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoItem'] as _iu91y1px.TodoItemEndpoint)
                  .updateItem(
                    session,
                    itemId: params['itemId'],
                    title: params['title'],
                    description: params['description'],
                    dueDate: params['dueDate'],
                    priority: params['priority'],
                    assignedToUserId: params['assignedToUserId'],
                    assignedToName: params['assignedToName'],
                    subtasksJson: params['subtasksJson'],
                    workSessionsJson: params['workSessionsJson'],
                    recurrence: params['recurrence'],
                  ),
        ),
        'toggleSubtask': _is.MethodConnector(
          name: 'toggleSubtask',
          params: {
            'itemId': _is.ParameterDescription(
              name: 'itemId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'subtaskId': _is.ParameterDescription(
              name: 'subtaskId',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoItem'] as _iu91y1px.TodoItemEndpoint)
                  .toggleSubtask(
                    session,
                    itemId: params['itemId'],
                    subtaskId: params['subtaskId'],
                  ),
        ),
        'toggleComplete': _is.MethodConnector(
          name: 'toggleComplete',
          params: {
            'itemId': _is.ParameterDescription(
              name: 'itemId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoItem'] as _iu91y1px.TodoItemEndpoint)
                  .toggleComplete(
                    session,
                    itemId: params['itemId'],
                  ),
        ),
        'startTimer': _is.MethodConnector(
          name: 'startTimer',
          params: {
            'itemId': _is.ParameterDescription(
              name: 'itemId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoItem'] as _iu91y1px.TodoItemEndpoint)
                  .startTimer(
                    session,
                    itemId: params['itemId'],
                  ),
        ),
        'pauseTimer': _is.MethodConnector(
          name: 'pauseTimer',
          params: {
            'itemId': _is.ParameterDescription(
              name: 'itemId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoItem'] as _iu91y1px.TodoItemEndpoint)
                  .pauseTimer(
                    session,
                    itemId: params['itemId'],
                  ),
        ),
        'deleteItem': _is.MethodConnector(
          name: 'deleteItem',
          params: {
            'itemId': _is.ParameterDescription(
              name: 'itemId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoItem'] as _iu91y1px.TodoItemEndpoint)
                  .deleteItem(
                    session,
                    itemId: params['itemId'],
                  ),
        ),
        'reorderItems': _is.MethodConnector(
          name: 'reorderItems',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'itemIds': _is.ParameterDescription(
              name: 'itemIds',
              type: _is.getType<List<int>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoItem'] as _iu91y1px.TodoItemEndpoint)
                  .reorderItems(
                    session,
                    listId: params['listId'],
                    itemIds: params['itemIds'],
                  ),
        ),
        'getActivities': _is.MethodConnector(
          name: 'getActivities',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoItem'] as _iu91y1px.TodoItemEndpoint)
                  .getActivities(
                    session,
                    listId: params['listId'],
                    limit: params['limit'],
                  ),
        ),
      },
    );
    connectors['todoList'] = _is.EndpointConnector(
      name: 'todoList',
      endpoint: endpoints['todoList']!,
      methodConnectors: {
        'getLists': _is.MethodConnector(
          name: 'getLists',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .getLists(session),
        ),
        'setDisplayName': _is.MethodConnector(
          name: 'setDisplayName',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .setDisplayName(
                    session,
                    params['name'],
                  ),
        ),
        'getDisplayName': _is.MethodConnector(
          name: 'getDisplayName',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .getDisplayName(session),
        ),
        'createList': _is.MethodConnector(
          name: 'createList',
          params: {
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'color': _is.ParameterDescription(
              name: 'color',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .createList(
                    session,
                    title: params['title'],
                    description: params['description'],
                    color: params['color'],
                  ),
        ),
        'updateList': _is.MethodConnector(
          name: 'updateList',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'color': _is.ParameterDescription(
              name: 'color',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .updateList(
                    session,
                    listId: params['listId'],
                    title: params['title'],
                    description: params['description'],
                    color: params['color'],
                  ),
        ),
        'deleteList': _is.MethodConnector(
          name: 'deleteList',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .deleteList(
                    session,
                    params['listId'],
                  ),
        ),
        'getMembers': _is.MethodConnector(
          name: 'getMembers',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .getMembers(
                    session,
                    params['listId'],
                  ),
        ),
        'inviteMember': _is.MethodConnector(
          name: 'inviteMember',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<_iuyx70r3.MemberRole>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .inviteMember(
                    session,
                    listId: params['listId'],
                    email: params['email'],
                    role: params['role'],
                  ),
        ),
        'getOrCreateInviteCode': _is.MethodConnector(
          name: 'getOrCreateInviteCode',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .getOrCreateInviteCode(
                    session,
                    params['listId'],
                  ),
        ),
        'joinListByInviteCode': _is.MethodConnector(
          name: 'joinListByInviteCode',
          params: {
            'codeOrLink': _is.ParameterDescription(
              name: 'codeOrLink',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .joinListByInviteCode(
                    session,
                    params['codeOrLink'],
                  ),
        ),
        'removeMember': _is.MethodConnector(
          name: 'removeMember',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'memberUserId': _is.ParameterDescription(
              name: 'memberUserId',
              type: _is.getType<_is.UuidValue?>(),
              nullable: true,
            ),
            'memberId': _is.ParameterDescription(
              name: 'memberId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .removeMember(
                    session,
                    listId: params['listId'],
                    memberUserId: params['memberUserId'],
                    memberId: params['memberId'],
                  ),
        ),
        'sendChatMessage': _is.MethodConnector(
          name: 'sendChatMessage',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'message': _is.ParameterDescription(
              name: 'message',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'recipientUserId': _is.ParameterDescription(
              name: 'recipientUserId',
              type: _is.getType<_is.UuidValue?>(),
              nullable: true,
            ),
            'recipientName': _is.ParameterDescription(
              name: 'recipientName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'isPrivate': _is.ParameterDescription(
              name: 'isPrivate',
              type: _is.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .sendChatMessage(
                    session,
                    listId: params['listId'],
                    message: params['message'],
                    recipientUserId: params['recipientUserId'],
                    recipientName: params['recipientName'],
                    isPrivate: params['isPrivate'],
                  ),
        ),
        'getChatMessages': _is.MethodConnector(
          name: 'getChatMessages',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'limit': _is.ParameterDescription(
              name: 'limit',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .getChatMessages(
                    session,
                    params['listId'],
                    limit: params['limit'],
                  ),
        ),
        'getUserProfileData': _is.MethodConnector(
          name: 'getUserProfileData',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .getUserProfileData(session),
        ),
        'getCurrentUserEmail': _is.MethodConnector(
          name: 'getCurrentUserEmail',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .getCurrentUserEmail(session),
        ),
        'saveUserProfileData': _is.MethodConnector(
          name: 'saveUserProfileData',
          params: {
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'bio': _is.ParameterDescription(
              name: 'bio',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'avatarIndex': _is.ParameterDescription(
              name: 'avatarIndex',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'avatarEmoji': _is.ParameterDescription(
              name: 'avatarEmoji',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'themeMode': _is.ParameterDescription(
              name: 'themeMode',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'notificationsEnabled': _is.ParameterDescription(
              name: 'notificationsEnabled',
              type: _is.getType<bool?>(),
              nullable: true,
            ),
            'locale': _is.ParameterDescription(
              name: 'locale',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .saveUserProfileData(
                    session,
                    displayName: params['displayName'],
                    bio: params['bio'],
                    avatarIndex: params['avatarIndex'],
                    avatarEmoji: params['avatarEmoji'],
                    status: params['status'],
                    themeMode: params['themeMode'],
                    notificationsEnabled: params['notificationsEnabled'],
                    locale: params['locale'],
                  ),
        ),
        'updateUserProfileInfo': _is.MethodConnector(
          name: 'updateUserProfileInfo',
          params: {
            'displayName': _is.ParameterDescription(
              name: 'displayName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'bio': _is.ParameterDescription(
              name: 'bio',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'avatarEmoji': _is.ParameterDescription(
              name: 'avatarEmoji',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .updateUserProfileInfo(
                    session,
                    displayName: params['displayName'],
                    bio: params['bio'],
                    avatarEmoji: params['avatarEmoji'],
                    status: params['status'],
                  ),
        ),
        'getMemberProfile': _is.MethodConnector(
          name: 'getMemberProfile',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'memberUserId': _is.ParameterDescription(
              name: 'memberUserId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .getMemberProfile(
                    session,
                    listId: params['listId'],
                    memberUserId: params['memberUserId'],
                  ),
        ),
        'watchList': _is.MethodStreamConnector(
          name: 'watchList',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _is.MethodStreamReturnType.streamType,
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['todoList'] as _iw2gkoqs.TodoListEndpoint)
                  .watchList(
                    session,
                    params['listId'],
                  ),
        ),
      },
    );
    connectors['todoNote'] = _is.EndpointConnector(
      name: 'todoNote',
      endpoint: endpoints['todoNote']!,
      methodConnectors: {
        'getNotes': _is.MethodConnector(
          name: 'getNotes',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoNote'] as _ic7eu8gt.TodoNoteEndpoint)
                  .getNotes(
                    session,
                    listId: params['listId'],
                  ),
        ),
        'createNote': _is.MethodConnector(
          name: 'createNote',
          params: {
            'listId': _is.ParameterDescription(
              name: 'listId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'content': _is.ParameterDescription(
              name: 'content',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'color': _is.ParameterDescription(
              name: 'color',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'isPinned': _is.ParameterDescription(
              name: 'isPinned',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoNote'] as _ic7eu8gt.TodoNoteEndpoint)
                  .createNote(
                    session,
                    listId: params['listId'],
                    title: params['title'],
                    content: params['content'],
                    color: params['color'],
                    isPinned: params['isPinned'],
                  ),
        ),
        'updateNote': _is.MethodConnector(
          name: 'updateNote',
          params: {
            'noteId': _is.ParameterDescription(
              name: 'noteId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'content': _is.ParameterDescription(
              name: 'content',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'color': _is.ParameterDescription(
              name: 'color',
              type: _is.getType<int?>(),
              nullable: true,
            ),
            'isPinned': _is.ParameterDescription(
              name: 'isPinned',
              type: _is.getType<bool?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoNote'] as _ic7eu8gt.TodoNoteEndpoint)
                  .updateNote(
                    session,
                    noteId: params['noteId'],
                    title: params['title'],
                    content: params['content'],
                    color: params['color'],
                    isPinned: params['isPinned'],
                  ),
        ),
        'togglePin': _is.MethodConnector(
          name: 'togglePin',
          params: {
            'noteId': _is.ParameterDescription(
              name: 'noteId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoNote'] as _ic7eu8gt.TodoNoteEndpoint)
                  .togglePin(
                    session,
                    noteId: params['noteId'],
                  ),
        ),
        'deleteNote': _is.MethodConnector(
          name: 'deleteNote',
          params: {
            'noteId': _is.ParameterDescription(
              name: 'noteId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['todoNote'] as _ic7eu8gt.TodoNoteEndpoint)
                  .deleteNote(
                    session,
                    noteId: params['noteId'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
