// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:courseku_mobile/models/user_model.dart';
import 'package:courseku_mobile/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../theme.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late AuthProvider authProvider = Provider.of(context);
  late UserModel user = authProvider.user;
  Future fetchProfile() async {
    var response = await http.get(Uri.parse(
        'http://courseku.herokuapp.com/api/profile/' + user.id.toString()));

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Profile'),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 195,
                decoration: BoxDecoration(
                  color: primaryTextColor,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 26,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile',
                      style: headerTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 78,
                          decoration: const BoxDecoration(
                            color: Color(0xffffffff),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              user.name[0],
                              style: primaryTextStyle.copyWith(
                                fontSize: 36,
                                color: secondaryTextColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: primaryTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Reputation',
                              style: secondaryTextStyle.copyWith(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '120 Points',
                              style: secondaryTextStyle.copyWith(
                                  // color: Colors.white,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              DefaultTabController(
                length: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TabBar(
                      labelColor: primaryTextColor,
                      tabs: const [
                        Tab(
                          text: 'Bookmarked',
                        ),
                        Tab(
                          text: 'Liked',
                        ),
                        Tab(
                          text: 'Submitted',
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 30,
                            ),
                            child: FutureBuilder(
                              future: fetchProfile(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot
                                      .data['data']['bookmarked'].length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          snapshot.data['data']['bookmarked']
                                                          [index]['tutorials']
                                                      ['name'] !=
                                                  null
                                              ? Text(
                                                  snapshot.data['data']
                                                          ['bookmarked'][index]
                                                      ['tutorials']['name'],
                                                  style:
                                                      headerTextStyle.copyWith(
                                                    fontWeight: medium,
                                                    fontSize: 18,
                                                  ))
                                              : Text('No Bookmark'),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text('Loading...');
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 30,
                            ),
                            child: FutureBuilder(
                              future: fetchProfile(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      snapshot.data['data']['liked'].length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data['data']['liked']
                                                [index]['tutorial']['name'],
                                            style: headerTextStyle.copyWith(
                                              fontWeight: medium,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text('Loading...');
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 30,
                            ),
                            child: FutureBuilder(
                              future: fetchProfile(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      snapshot.data['data']['submitted'].length,
                                  itemBuilder: (context, index) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6,
                                                        horizontal: 8),
                                                margin: const EdgeInsets.only(
                                                  right: 6,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: snapshot.data['data']
                                                                  ['submitted'][
                                                              index]['status'] ==
                                                          'Draft'
                                                      ? Colors.grey
                                                      : Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  snapshot.data['data']
                                                                  ['submitted'][
                                                              index]['status'] ==
                                                          'Draft'
                                                      ? 'Under Review'
                                                      : 'Approved',
                                                  style:
                                                      headerTextStyle.copyWith(
                                                    fontWeight: medium,
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                snapshot.data['data']
                                                        ['submitted'][index]
                                                    ['name'],
                                                style: headerTextStyle.copyWith(
                                                  fontWeight: medium,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text('Loading...');
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
