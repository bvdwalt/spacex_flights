import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:spacex_flights/src/helpers/url_helper.dart';
import 'package:spacex_flights/src/models/flight.dart';

class FlightDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Flight flight = ModalRoute.of(context).settings.arguments;
    //final NumberFormat _numberFormat = new NumberFormat("###,###.##");

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    elevation: 0.0,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: flight.links.missionPatchSmall == null
                          ? Center(child: Text("No Image yet"))
                          : Image.network(
                              flight.links.missionPatchSmall,
                              fit: BoxFit.scaleDown,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                            ),
                    )),
              ];
            },
            body: GridView.count(
              physics: BouncingScrollPhysics(),
              crossAxisCount: 1,
              childAspectRatio: 10,
              padding: EdgeInsets.only(left: 20, right: 20),
              children: <Widget>[
                detailWidget("Flight Number", flight.flightNumber.toString()),
                detailWidget("Mission Name", flight.missionName),
                detailWidget("Launch Site", flight.launchSite.siteNameLong),
                detailWidget(
                    "Launch Success",
                    flight.launchSuccess == null
                        ? ""
                        : flight.launchSuccess ? "Yes" : "No"),
                detailWidget(
                    "Launch Failure Reason",
                    flight.launchSuccess == null || flight.launchSuccess == true
                        ? ""
                        : "${flight.launchFailureDetail.reason}"),
                detailWidget(
                    "Launch Tentative", flight.isTentative ? "Yes" : "No"),
                detailWidget("To Be Determined", flight.tbd ? "Yes" : "No"),
                detailWidget(
                    "Launch Date",
                    DateFormat.yMMMd().format(flight.launchDateUtc.toLocal()) +
                        ' ' +
                        DateFormat.Hms()
                            .format(flight.launchDateUtc.toLocal())),
                detailWidget("Rocket Name", flight.rocket.rocketName),
                detailWidget(
                    "First Stage Block",
                    flight.rocket.firstStage.cores.length == 0 ||
                            flight.rocket.firstStage.cores[0].block == null
                        ? ""
                        : flight.rocket.firstStage.cores[0].block.toString()),
                detailWidget(
                    "First Stage Serial",
                    flight.rocket.firstStage.cores.length == 0 ||
                            flight.rocket.firstStage.cores[0].block == null
                        ? ""
                        : flight.rocket.firstStage.cores[0].coreSerial),
                detailWidget(
                    "First Stage Reused",
                    flight.rocket.firstStage.cores.length == 0 ||
                            flight.rocket.firstStage.cores[0].reused == null
                        ? ""
                        : flight.rocket.firstStage.cores[0].reused
                            ? "Yes ${flight.rocket.firstStage.cores[0].flight != null ? "(" + flight.rocket.firstStage.cores[0].flight.toString() + " times)" : ""}"
                            : "No"),
                detailWidget(
                    "First Stage Landing Intent",
                    flight.rocket.firstStage.cores.length == 0 ||
                            flight.rocket.firstStage.cores[0].landingIntent ==
                                null
                        ? ""
                        : flight.rocket.firstStage.cores[0].landingIntent
                            ? "Yes"
                            : "No" ?? ""),
                detailWidget(
                    "First Stage Landing Success",
                    flight.rocket.firstStage.cores.length == 0 ||
                            flight.rocket.firstStage.cores[0].landSuccess ==
                                null
                        ? ""
                        : flight.rocket.firstStage.cores[0].landSuccess
                            ? "Yes"
                            : "No" ?? ""),
                detailWidget(
                    "Second Stage Block",
                    flight.rocket.firstStage.cores.length == 0 ||
                            flight.rocket.secondStage.block == null
                        ? ""
                        : flight.rocket.secondStage.block.toString()),
                detailWidget(
                    "Payload Orbit",
                    flight.rocket.secondStage.payloads
                                .map((e) => e.orbit)
                                .length ==
                            0
                        ? ""
                        : flight.rocket.secondStage.payloads
                            .map((e) => e.orbit)
                            .join(',')),
                detailWidget(
                    "Payload NORAD IDs",
                    flight.rocket.secondStage.payloads
                                .where((element) => element.noradId.length != 0)
                                .length ==
                            0
                        ? ""
                        : flight.rocket.secondStage.payloads
                            .where((element) => element.noradId.length != 0)
                            .map((e) => e.noradId)
                            .join(',')
                            .replaceAll('[', '')
                            .replaceAll(']', '')),
                detailWidget(
                    "Payload Customers",
                    flight.rocket.secondStage.payloads
                                .map((e) => e.customers)
                                .where((element) => element.length != 0)
                                .length ==
                            0
                        ? ""
                        : flight.rocket.secondStage.payloads
                            .where((element) => element.customers.length != 0)
                            .map((e) => e.customers)
                            .join(',')
                            .replaceAll('[', '')
                            .replaceAll(']', '')),
                detailWidget(
                    "Payload Nationality",
                    flight.rocket.secondStage.payloads
                                .map((e) => e.nationality)
                                .where((element) => element != null)
                                .length ==
                            0
                        ? ""
                        : flight.rocket.secondStage.payloads
                            .where((element) => element.nationality != null)
                            .map((e) => e.nationality)
                            .join(',')),
                detailWidget(
                    "Payload Manufacturer",
                    flight.rocket.secondStage.payloads
                                .map((e) => e.manufacturer)
                                .where((element) => element != null)
                                .length ==
                            0
                        ? ""
                        : flight.rocket.secondStage.payloads
                            .where((element) => element.manufacturer != null)
                            .map((e) => e.manufacturer)
                            .join(',')),
                detailWidget(
                    "Payload Type",
                    flight.rocket.secondStage.payloads
                                .map((e) => e.payloadType)
                                .length ==
                            0
                        ? ""
                        : flight.rocket.secondStage.payloads
                            .map((e) => e.payloadType)
                            .join(',')),
                detailWidget(
                    "Payload Mass (kg)",
                    flight.rocket.secondStage.payloads
                                .map((e) => e.payloadMassKg)
                                .where((element) => element != null)
                                .length ==
                            0
                        ? ""
                        : flight.rocket.secondStage.payloads
                            .where((element) => element.payloadMassKg != null)
                            .map((e) => e.payloadMassKg.toString())
                            .join(',')),
                detailWidgetWithLink("Wikipedia Link", flight.links.wikipedia),
                detailWidgetWithLink(
                    "Reddit Campaign", flight.links.redditCampaign),
                detailWidgetWithLink(
                    "Reddit Launch", flight.links.redditLaunch),
                detailWidgetWithLink(
                    "Reddit Recovery", flight.links.redditRecovery),
                detailWidgetWithLink("Press Kit", flight.links.presskit),
                detailWidgetWithLink(
                    "YouTube",
                    flight.links.youtubeId == null
                        ? null
                        : 'https://www.youtube.com/watch?v=${flight.links.youtubeId}'),
              ],
            )),
      ),
    );
  }
}

detailWidget(String title, String value) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Text(
          title,
          textAlign: TextAlign.left,
        )),
        Expanded(
            child: AutoSizeText(
          value ?? '',
          textAlign: TextAlign.right,
          overflow: TextOverflow.fade,
          maxLines: 2,
        ))
      ]);
}

detailWidgetWithLink(String title, String value) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: Text(
          title,
          textAlign: TextAlign.left,
        )),
        Expanded(
            child: GestureDetector(
                onTap: () {
                  print(value);
                  launchURL(value);
                },
                child: AutoSizeText(
                  value ?? '',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.blue),
                  maxLines: 2,
                )))
      ]);
}
