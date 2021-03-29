import 'package:flutter/material.dart';
import 'package:laraman/modules/account/controllers/account_controller.dart';
import 'package:get/get.dart';

class RightDrawer extends StatelessWidget {
  final AccountController accountController = AccountController.to;
  @override
  Widget build(BuildContext context) {
    var isOpen = [false, false, false].obs;
    return Container(
      color: Colors.indigo,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(children: [
            Row(
              children: [
                Text(
                  "Settings",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                Spacer(),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () => accountController.signOut(),
                    child: Text(
                      'Sign out',
                      style: TextStyle(color: Colors.indigo),
                    ))
              ],
            ),
            Divider(),
            Expanded(
              child: Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: ListView(
                  children: [
                    Obx(
                      () => ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: ExpansionTile(
                          backgroundColor: Colors.indigo.shade600,
                          childrenPadding: EdgeInsets.only(left: 10),
                          leading: Icon(
                            Icons.qr_code_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Your Profile',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          collapsedBackgroundColor: Colors.indigo,
                          trailing: (isOpen.first == false)
                              ? Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                          children: [
                            ListTile(
                              leading: Icon(Icons.phone,
                                  color: Colors.grey.shade100),
                              title: Text('PhoneNumber',
                                  style:
                                      TextStyle(color: Colors.indigo.shade300)),
                              subtitle: Text(
                                  accountController.account.value.phoneNumber,
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.edit,
                                  size: 15,
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.person,
                                  color: Colors.grey.shade100),
                              title: Text('Full Name',
                                  style:
                                      TextStyle(color: Colors.indigo.shade300)),
                              subtitle: Text(
                                  accountController.account.value.firstName +
                                      ' ' +
                                      accountController.account.value.lastName,
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.edit,
                                  size: 15,
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone,
                                  color: Colors.grey.shade100),
                              title: Text('Email',
                                  style:
                                      TextStyle(color: Colors.indigo.shade300)),
                              subtitle: Text(
                                  accountController.account.value.email ??
                                      'No Email set',
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.edit,
                                  size: 15,
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                            ListTile(
                              isThreeLine: true,
                              leading: Icon(Icons.phone,
                                  color: Colors.grey.shade100),
                              title: Text('Address',
                                  style:
                                      TextStyle(color: Colors.indigo.shade300)),
                              subtitle: Text(
                                  accountController.account.value.address +
                                      ', \n' +
                                      accountController.account.value.city +
                                      ', ' +
                                      accountController.account.value.country,
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.edit,
                                  size: 15,
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                          ],
                          onExpansionChanged: (value) {
                            isOpen.first = value;
                          },
                        ),
                      ),
                    ),
                    Obx(
                      () => ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: ExpansionTile(
                          backgroundColor: Colors.indigo.shade600,
                          childrenPadding: EdgeInsets.only(left: 10),
                          leading: Icon(
                            Icons.account_circle_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Account settings',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          collapsedBackgroundColor: Colors.indigo,
                          trailing: (isOpen[1] == false)
                              ? Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                          children: [
                            ListTile(
                              leading: Icon(Icons.phone,
                                  color: Colors.grey.shade100),
                              title: Text('Limit',
                                  style:
                                      TextStyle(color: Colors.indigo.shade300)),
                              subtitle: Text('10 eur',
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.edit,
                                  size: 15,
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.language,
                                  color: Colors.grey.shade100),
                              title: Text('Language',
                                  style:
                                      TextStyle(color: Colors.indigo.shade300)),
                              subtitle: Text('English',
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.edit,
                                  size: 15,
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.access_time,
                                  color: Colors.grey.shade100),
                              title: Text('Timezone',
                                  style:
                                      TextStyle(color: Colors.indigo.shade300)),
                              subtitle: Text('GMT+1' ?? 'No Email set',
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.edit,
                                  size: 15,
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone,
                                  color: Colors.grey.shade100),
                              title: Text('Account Type',
                                  style:
                                      TextStyle(color: Colors.indigo.shade300)),
                              subtitle: Text('Personal',
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.edit,
                                  size: 15,
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.delete,
                                  color: Colors.grey.shade100),
                              title: Text('Delete Account',
                                  style:
                                      TextStyle(color: Colors.indigo.shade300)),
                              subtitle: Text('Remove me',
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.edit,
                                  size: 15,
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                          ],
                          onExpansionChanged: (value) {
                            isOpen[1] = value;
                          },
                        ),
                      ),
                    ),
                    Obx(
                      () => ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: ExpansionTile(
                          backgroundColor: Colors.indigo.shade600,
                          childrenPadding: EdgeInsets.only(left: 10),
                          leading: Icon(
                            Icons.settings,
                            size: 20,
                            color: Colors.white,
                          ),
                          title: Text(
                            'App Settings',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          collapsedBackgroundColor: Colors.indigo,
                          trailing: (isOpen[2] == false)
                              ? Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                          children: [
                            ListTile(
                              leading: Icon(Icons.notifications,
                                  color: Colors.grey.shade100),
                              title: Text('Notifications',
                                  style:
                                      TextStyle(color: Colors.indigo.shade300)),
                              subtitle: Text('Enabled',
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.edit,
                                  size: 15,
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.perm_media,
                                  color: Colors.grey.shade100),
                              title: Text('Permissions',
                                  style:
                                      TextStyle(color: Colors.indigo.shade300)),
                              subtitle: Text('Camera, Gallery, Storage',
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.edit,
                                  size: 15,
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.phone,
                                  color: Colors.grey.shade100),
                              title: Text('Theme',
                                  style:
                                      TextStyle(color: Colors.indigo.shade300)),
                              subtitle: Text('Light theme',
                                  style: TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.edit,
                                  size: 15,
                                ),
                                onPressed: () {
                                  print('object');
                                },
                              ),
                            ),
                          ],
                          onExpansionChanged: (value) {
                            isOpen[2] = value;
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.people,
                        size: 20,
                        color: Colors.white,
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Invite a friend',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.chat, color: Colors.grey.shade100),
                      title: Text('Help',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      subtitle: Text('Chat with us',
                          style: TextStyle(color: Colors.white)),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'made with ♥ in Ferizaj',
              style: TextStyle(color: Colors.indigo.shade800),
            )
          ]),
        ),
      ),
    );
  }
}
