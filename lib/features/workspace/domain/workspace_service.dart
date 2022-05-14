import 'package:diplom/features/workspace/data/local_workspace_data_source.dart';
import 'package:diplom/features/workspace/data/remote_workspace_data_source.dart';

class WorkspaceService {
  WorkspaceService({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final RemoteWorkspaceDataSource remoteDataSource;
  final LocalWorkspaceDataSource localDataSource;

  Future init() async {}
}
