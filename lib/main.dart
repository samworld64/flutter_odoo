import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

main() async {
  await dotenv.load();

  final client = OdooClient(dotenv.env['ERP_URL']!);
  try {
    await client.authenticate(dotenv.env['ERP_DB']!, dotenv.env['ERP_USER']!,
        dotenv.env['ERP_PASSWORD']!);
    final res = await client.callRPC('/web/session/modules', 'call', {});
    print('Modules - Installed modules: \n' + res.toString());
  } on OdooException catch (e) {
    print(e);
    client.close();
    exit(-1);
  }
  client.close();
}
